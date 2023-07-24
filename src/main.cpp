/******************************************************************************
 *                                                                            *
 * Copyright (C) 2023 MachineWare GmbH                                        *
 * All Rights Reserved                                                        *
 *                                                                            *
 * This is work is licensed under the terms described in the LICENSE file     *
 * found in the root directory of this source tree.                           *
 *                                                                            *
 ******************************************************************************/

#include "data.h"

#include <cstring>
#include <iostream>
#include <numeric>

#include <sys/prctl.h>

int64_t dot_prod_scalar(const array& src1, const array& src2) {
    return std::inner_product(src1.begin(), src1.end(), src2.begin(), 0);
}

extern "C" int64_t dot_prod_vec(int32_t* src1, int32_t* src2, int num);

int main() {
    int64_t result_scalar, result_vector;

    // Enable vector instructions for current thread
    if (prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON) != 0) {
        std::perror("Could not enable vector instructions");
        return errno;
    }

    result_scalar = dot_prod_scalar(source_data1, source_data2);
    result_vector = dot_prod_vec(source_data1.data(), source_data2.data(),
                                 DATA_NUM);

    std::cout << "Dot product calculator with RISC-V vector" << std::endl
              << "scalar result:\t" << result_scalar << std::endl
              << "vector result:\t" << result_vector << std::endl;

    if (result_scalar != result_vector) {
        std::cout << "Results are not equal!" << std::endl;
        return -1;
    }

    return 0;
}

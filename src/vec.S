/******************************************************************************
 *                                                                            *
 * Copyright (C) 2023 MachineWare GmbH                                        *
 * All Rights Reserved                                                        *
 *                                                                            *
 * This is work is licensed under the terms described in the LICENSE file     *
 * found in the root directory of this source tree.                           *
 *                                                                            *
 ******************************************************************************/

    .globl      dot_prod_vec
    .type       dot_prod_vec, @function
# int64_t dot_prod_vec(int32_t *src1, int32_t *src2, int data_num);
# a0=src1, a1=src2, a2=data_num
#
dot_prod_vec:
    xor         t3, t3, t3      # init temp teg
.loop_mul:
    vxor.vv     v3, v3, v3      # init temp reg

    vsetvli     t0, a2, e32,m1
    slli        t1, t0, 2
    vle32.v     v0, (a0)        # load src1
    add         a0, a0, t1
    vle32.v     v1, (a1)        # load src2
    add         a1, a1, t1
    sub         a2, a2, t0      # decr count
    vmul.vv     v2, v1, v0      # multiplication
    vredsum.vs  v3, v2, v3      # sum up products
    vmv.x.s     t2, v3          # move result to scalar reg
    add         t3, t3, t2      # sum up scalars
    bnez        a2, .loop_mul   # done ?
    mv          a0, t3          # return value
    ret

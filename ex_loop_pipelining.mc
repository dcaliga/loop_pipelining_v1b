/* $Id: ex01.mc,v 2.1 2005/06/14 22:16:46 jls Exp $ */

/*
 * Copyright 2005 SRC Computers, Inc.  All Rights Reserved.
 *
 *	Manufactured in the United States of America.
 *
 * SRC Computers, Inc.
 * 4240 N Nevada Avenue
 * Colorado Springs, CO 80907
 * (v) (719) 262-0213
 * (f) (719) 262-0223
 *
 * No permission has been granted to distribute this software
 * without the express permission of SRC Computers, Inc.
 *
 * This program is distributed WITHOUT ANY WARRANTY OF ANY KIND.
 */

#include <libmap.h>

void subr (int64_t A[], int64_t B[], int64_t C[], int64_t D[], int num, int64_t *time, int mapnum) {

    OBM_BANK_A (AL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_B (BL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_C (CL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_D (DL, int64_t, MAX_OBM_SIZE)
    int64_t t0, t1;
    int i;
    int64_t vx,vy;


    buffered_dma_cpu (CM2OBM, PATH_0, AL, MAP_OBM_stripe (1,"A"), A, 1, num*8);
    buffered_dma_cpu (CM2OBM, PATH_0, BL, MAP_OBM_stripe (1,"B"), B, 1, num*8);
    buffered_dma_cpu (CM2OBM, PATH_0, CL, MAP_OBM_stripe (1,"C"), C, 1, num*8);

    read_timer (&t0);

    for (i=0; i<num; i++) {
    for (i=0; i<num; i++) {
    vx = CL[i] * (AL[i]>BL[i] ? AL[i]-BL[i] : AL[i]+BL[i]);
    vy = vx + AL[i];
    vy = vy / 42;
    DL[i] = vy + CL[i];
    }
	}

    read_timer (&t1);

    *time = t1 - t0;


    buffered_dma_cpu (OBM2CM, PATH_0, DL, MAP_OBM_stripe (1,"D"), D, 1, num*8);

}

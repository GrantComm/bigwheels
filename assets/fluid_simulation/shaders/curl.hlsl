// Copyright 2017 Pavel Dobryakov
// Copyright 2022 Google LLC
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

#include "config.hlsli"

[numthreads(1, 1, 1)] void csmain(uint2 tid
                                  : SV_DispatchThreadID) {
    Coord coord = BaseVS(tid, Params.normalizationScale, Params.texelSize);

    float L         = UVelocity.SampleLevel(Sampler, coord.vL, 0).y;
    float R         = UVelocity.SampleLevel(Sampler, coord.vR, 0).y;
    float T         = UVelocity.SampleLevel(Sampler, coord.vT, 0).x;
    float B         = UVelocity.SampleLevel(Sampler, coord.vB, 0).x;
    float vorticity = R - L - T + B;

    Output[coord.xy] = float4(0.5 * vorticity, 0.0, 0.0, 1.0);
}
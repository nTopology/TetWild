// This file is part of TetWild, a software for generating tetrahedral meshes.
//
// Copyright (C) 2018 Yixin Hu <yixin.hu@nyu.edu>
//
// This Source Code Form is subject to the terms of the Mozilla Public License
// v. 2.0. If a copy of the MPL was not distributed with this file, You can
// obtain one at http://mozilla.org/MPL/2.0/.
//
// Created by Yixin Hu on 5/31/18.
//

#pragma once

#include <string>
#include <functional>

namespace tetwild {

// Forward declaration
enum class Step;

// Global arguments controlling the behavior of TetWild
struct Args {
    // Initial target edge-length at every vertex (in % of the bbox diagonal)
    double initial_edge_len_rel = 5.0;

    // Target epsilon (in % of the bbox diagonal)
    double eps_rel = 0.1;

    ////////////////
    // [Advanced] //
    ////////////////

    // Explicitly specify a sampling distance for triangles (in % of the bbox diagonal)
    int sampling_dist_rel = -1;

    // Run the algorithm in stage (as explain in p.8 of the paper)
    // If the first stage didn't succeed, call again with `stage = 2`,  etc.
    int stage = 1;

    // Multiplier for resizing the target-edge length around bad-quality vertices
    // See MeshRefinement::updateScalarField() for more details
    double adaptive_scalar = 0.6;

    // Energy threshold
    // If the max tet energy is below this threshold, the mesh optimization process is stopped.
    // Also used to determine where to resize the scalar field (if a tet incident to a vertex has larger energy than this threshold, then resize around this vertex).
    double filter_energy_thres = 10;

    // Threshold on the energy delta (avg and max) below which to rescale the target edge length scalar field
    double delta_energy_thres = 0.1;

    // Maximum number of mesh optimization iterations
    int max_num_passes = 80;

    // Sample points at voxel centers for initial Delaunay triangulation
    bool use_voxel_stuffing = true;

    // Use Laplacian smoothing on the faces/vertices covering an open boundary after the mesh optimization step (post-processing)
    bool smooth_open_boundary = false;

    // Target number of vertices (minimum), within 5% of tolerance
    int target_num_vertices = -1;

    // Background mesh for the edge length sizing field
    std::string background_mesh = "";

    ////////////////////
    // [Experimental] //
    ////////////////////

    // Use mmgs to simplify the input surface mesh if possible (i.e. it doesn't return an empty mesh)
    bool use_mmgs = false;

    // Use mmg3d to optimize the final tet mesh if possible (i.e. as soon as all vertices can be rounded)
    bool use_mmg3d = false;

    // Stop TetWild's optimization process early if using mmg3d for post-processing.
    // When disabled, then mmg3d will only be used as a final post-processing.
    // You can set to false if you feel the hybrid pipeline creates artifacts.
    bool mmg3d_stop_early = true;

    // Only defers to mmg3d if there are no slivers with a dihedral angle below the given threshold (in degree)
    // Skip the check if 0 is given
    double mmg3d_slivers_thres = 0;

    // Angle threshold (in °) for sharp feature detection in mmg (0 means disabled).
    double mmg_angle_thres = 45.0;

    ///////////////
    // [Logging] //
    ///////////////

    bool write_csv_file = true;
    std::string working_dir = "";
    std::string postfix = "_";
    std::string csv_file = "";
    int save_mid_result = -1; // save intermediate result

    bool is_quiet = false;

    /////////////////
    // [Callbacks] //
    /////////////////

    // User callback called between every step. The first argument is an integer
    // indicating what substep is currently being performed. The second argument
    // is a very loose percentage (between 0 and 1) indicating the progress of
    // the current step.
    //
    // Cancellation can be achieved by throwing an exception within this callback.
    //
    // Codes for the step corresponding to the first argument:
    // 00 = Preprocessing (surface simplification)
    // 01 = Delaunay tetrahedralization
    // 02 = Face matching
    // 03 = BSP subdivision
    // 04 = Initial tetrahedralization
    // 10 = Mesh optimization
    std::function<void(Step, double)> user_callback;
};

// Different steps of the pipeline
enum class Step {
    Preprocess   = 0,
    Delaunay     = 1,
    FaceMatching = 2,
    BSP          = 3,
    Tetra        = 4,
    Optimize     = 10,
};

} // namespace tetwild

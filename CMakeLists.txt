cmake_minimum_required(VERSION 3.10)

if(WIN32)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4244")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4267")
endif()

### Sources ###

set(sources
    src/heads.cpp
    src/heads.h
    src/EdgeSplitter.cpp
    src/EdgeSplitter.h
    src/EdgeCollapser.cpp
    src/EdgeCollapser.h
    src/EdgeRemover.cpp
    src/EdgeRemover.h
    src/tetwild.cpp
    src/LocalOperations.cpp
    src/LocalOperations.h
    src/Preprocess.cpp
    src/Preprocess.h
    src/MeshConformer.cpp
    src/MeshConformer.h
    src/DelaunayTetrahedralization.cpp
    src/DelaunayTetrahedralization.h
    src/BSPSubdivision.cpp
    src/BSPSubdivision.h
    src/SimpleTetrahedralization.cpp
    src/SimpleTetrahedralization.h
    src/MeshRefinement.cpp
    src/MeshRefinement.h
    src/VertexSmoother.cpp
    src/VertexSmoother.h
    src/InoutFiltering.cpp
    src/InoutFiltering.h
    pymesh/MshSaver.cpp
    pymesh/MshSaver.h
    pymesh/MshLoader.cpp
    pymesh/MshLoader.h
    pymesh/Exception.h
)

# This corrects cmake's default Visual Studio's ugly folder organization
source_group("" FILES ${sources})

add_library(tetwild ${sources})

target_include_directories(tetwild PUBLIC . include pymesh)

set_target_properties(tetwild PROPERTIES COMPILE_FLAGS "-DMUTE_COUT")

target_link_libraries(tetwild PUBLIC glm geogram libigl2 cgal2)

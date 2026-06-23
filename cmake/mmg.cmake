################################################################################

set(MMG_SOURCE_DIR ${TETWILD_EXTERNAL}/mmg)
set(MMG_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/mmg)

################################################################################

set(CMAKE_RELEASE_VERSION_MAJOR "5")
set(CMAKE_RELEASE_VERSION_MINOR "3")
set(CMAKE_RELEASE_VERSION_PATCH "11")
set(CMAKE_RELEASE_DATE "Apr. 10, 2017")

set(CMAKE_RELEASE_VERSION
    "${CMAKE_RELEASE_VERSION_MAJOR}.${CMAKE_RELEASE_VERSION_MINOR}.${CMAKE_RELEASE_VERSION_PATCH}")

if(NOT WIN32)
  # Set preprocessor flags to say that we are posix and gnu compatible
  set(DEF_POSIX "#define MMG_POSIX")
  set(DEF_GNU "#define MMG_GNU")
elseif(MINGW)
   set(DEF_GNU "#define MMG_GNU")
endif()

configure_file(${MMG_SOURCE_DIR}/src/common/mmgcmakedefines.h.in ${MMG_BINARY_DIR}/mmgcmakedefines.h @ONLY)
configure_file(${MMG_SOURCE_DIR}/src/common/mmgversion.h.in ${MMG_BINARY_DIR}/mmgversion.h @ONLY)

# Copy stupid headers
configure_file(${MMG_SOURCE_DIR}/src/common/libmmgtypes.h ${MMG_BINARY_DIR}/mmg/mmgs/libmmgtypes.h COPYONLY)
configure_file(${MMG_SOURCE_DIR}/src/common/libmmgtypes.h ${MMG_BINARY_DIR}/mmg/mmg2d/libmmgtypes.h COPYONLY)
configure_file(${MMG_SOURCE_DIR}/src/common/libmmgtypes.h ${MMG_BINARY_DIR}/mmg/mmg3d/libmmgtypes.h COPYONLY)
configure_file(${MMG_SOURCE_DIR}/src/mmgs/libmmgs.h ${MMG_BINARY_DIR}/mmg/mmgs/libmmgs.h COPYONLY)
configure_file(${MMG_SOURCE_DIR}/src/mmg2d/libmmg2d.h ${MMG_BINARY_DIR}/mmg/mmg2d/libmmg2d.h COPYONLY)
configure_file(${MMG_SOURCE_DIR}/src/mmg3d/libmmg3d.h ${MMG_BINARY_DIR}/mmg/mmg3d/libmmg3d.h COPYONLY)

if(NOT WIN32)
  configure_file(${MMG_SOURCE_DIR}/git_log_mmg.h ${MMG_BINARY_DIR}/git_log_mmg.h COPYONLY)
endif()

################################################################################

set(MMG_COMMON_SOURCES
	anisosiz.c
	inout.c
	intmet.c
	libmmgcommon.h
	mettools.c
	mmg.c
	scalem.c
	anisomovpt.c
	API_functions.c
	bezier.c
	boulep.c
	chrono.c
	chrono.h
	eigenv.c
	eigenv.h
	hash.c
	inlined_functions.h
	isosiz.c
	libmmgtypes.h
	librnbg.c
	librnbg.h
	quality.c
	tools.c
)

set(MMG_MMG_SOURCES
    libmmg.h
)

set(MMG_MMGS_SOURCES
	analys_s.c
	anisomovpt_s.c
	anisosiz_s.c
	API_functions_s.c
	API_functionsf_s.c
	bezier_s.c
	boulep_s.c
	chkmsh_s.c
	colver_s.c
	gentools_s.c
	hash_s.c
	inout_s.c
	intmet_s.c
	isosiz_s.c
	libmmgs.c
	libmmgs.h
	libmmgs_tools.c
	librnbg_s.c
	mmgs.h
	mmgs1.c
	mmgs2.c
	movpt_s.c
	quality_s.c
	split_s.c
	swapar_s.c
	variadic_s.c
	zaldy_s.c
)

set(MMG_MMG2D_SOURCES
	analys_2d.c
	anisomovpt_2d.c
	anisosiz_2d.c
	API_functions_2d.c
	API_functionsf_2d.c
	bezier_2d.c
	boulep_2d.c
	cenrad_2d.c
	chkmsh_2d.c
	colver_2d.c
	delone_2d.c
	enforcement_2d.c
	hash_2d.c
	inout_2d.c
	intmet_2d.c
	isosiz_2d.c
	length_2d.c
	libmmg2d.c
	libmmg2d.h
	libmmg2d_tools.c
	lissmet_2d.c
	locate_2d.c
	mmg2d.h
	mmg2d1.c
	mmg2d2.c
	mmg2d6.c
	mmg2d9.c
	movpt_2d.c
	quality_2d.c
	scalem_2d.c
	solmap_2d.c
	split_2d.c
	swapar_2d.c
	tools_2d.c
	variadic_2d.c
	velextls_2d.c
	zaldy_2d.c
)

set(MMG_MMG3D_SOURCES
	analys_3d.c
	anisomovpt_3d.c
	anisosiz_3d.c
	API_functions_3d.c
	API_functionsf_3d.c
	bezier_3d.c
	boulep_3d.c
	cenrad_3d.c
	chkmsh_3d.c
	colver_3d.c
	delaunay_3d.c
	hash_3d.c
	inlined_functions_3d.h
	inout_3d.c
	intmet_3d.c
	isosiz_3d.c
	libmmg3d.c
	libmmg3d.h
	libmmg3d_tools.c
	librnbg_3d.c
	mmg3d.h
	mmg3d1.c
	mmg3d1_delone.c
	mmg3d1_pattern.c
	mmg3d2.c
	mmg3d3.c
	movpt_3d.c
   PRoctree_3d.c
	optbdry_3d.c
	optlap_3d.c
	opttyp_3d.c
	quality_3d.c
	split_3d.c
	swap_3d.c
	swapgen_3d.c
	tools_3d.c
	variadic_3d.c
	velextls_3d.c
	zaldy_3d.c
)

################################################################################

add_library(mmg SHARED "${MMG_BINARY_DIR}/mmgcommon.h")
source_group(common FILES "${MMG_BINARY_DIR}/mmgcommon.h")

function(mmg_add_sources folder)
    foreach(filename IN ITEMS ${ARGN})
        set(filepath "${MMG_SOURCE_DIR}/src/${folder}/${filename}")
        target_sources(mmg PRIVATE ${filepath})
        source_group(${folder} FILES ${filepath})
    endforeach()
endfunction()

mmg_add_sources(common ${MMG_COMMON_SOURCES})
mmg_add_sources(mmg ${MMG_MMG_SOURCES})
mmg_add_sources(mmgs ${MMG_MMGS_SOURCES})
mmg_add_sources(mmg2d ${MMG_MMG2D_SOURCES})
mmg_add_sources(mmg3d ${MMG_MMG3D_SOURCES})

add_library(mmg::mmg ALIAS mmg)

target_include_directories(mmg PUBLIC SYSTEM
    ${MMG_SOURCE_DIR}/src
    ${MMG_SOURCE_DIR}/src/common
    ${MMG_SOURCE_DIR}/src/mmg
    ${MMG_SOURCE_DIR}/src/mmgs
    ${MMG_SOURCE_DIR}/src/mmg2d
    ${MMG_SOURCE_DIR}/src/mmg3d
    ${MMG_BINARY_DIR}
)

set_target_properties(mmg PROPERTIES CXX_VISIBILITY_PRESET hidden)
ntop_output_directory(mmg)

################################################################################

include(GenerateExportHeader)
generate_export_header(mmg
    BASE_NAME MMG5
    EXPORT_FILE_NAME ${MMG_BINARY_DIR}/libmmgexport.h)

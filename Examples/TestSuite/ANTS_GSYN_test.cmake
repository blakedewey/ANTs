#####################################################################################
#####################################################################################
set(THIS_TEST_NAME ANTS_GSYN)
set(OUTPUT_PREFIX ${CMAKE_BINARY_DIR}/TEST_${THIS_TEST_NAME} )
set(WARP ${OUTPUT_PREFIX}Warp.nii.gz ${OUTPUT_PREFIX}Affine.txt )
set(INVERSEWARP -i ${OUTPUT_PREFIX}Affine.txt ${OUTPUT_PREFIX}InverseWarp.nii.gz )
set(WARP_IMAGE ${CMAKE_BINARY_DIR}/${THIS_TEST_NAME}_warped.nii.gz)
set(INVERSEWARP_IMAGE ${CMAKE_BINARY_DIR}/${THIS_TEST_NAME}_inversewarped.nii.gz)


add_test(${THIS_TEST_NAME} ${TEST_BINARY_DIR}/ANTS 2
 -m CC[ ${R16_IMAGE}, ${R64_IMAGE},1 ,3 ] -r Gauss[ 3, 0 ]
 -t SyN[0.25] -i 50x50x50 -o ${OUTPUT_PREFIX}.nii.gz
 )

add_test(${THIS_TEST_NAME}_WARP ${TEST_BINARY_DIR}/WarpImageMultiTransform 2
 ${R64_IMAGE} ${WARP_IMAGE} ${WARP} -R ${R16_IMAGE} )
set_property(TEST ${THIS_TEST_NAME}_WARP APPEND PROPERTY DEPENDS ${THIS_TEST_NAME})

add_test(${THIS_TEST_NAME}_JPG ${TEST_BINARY_DIR}/ConvertToJpg ${WARP_IMAGE} ${THIS_TEST_NAME}.jpg)
set_property(TEST ${THIS_TEST_NAME}_JPG APPEND PROPERTY DEPENDS ${THIS_TEST_NAME})

add_test(${THIS_TEST_NAME}_WARP_METRIC_0
 ${TEST_BINARY_DIR}/MeasureImageSimilarity 2 0
 ${R16_IMAGE} ${WARP_IMAGE}
 ${OUTPUT_PREFIX}log.txt ${OUTPUT_PREFIX}metric.nii.gz
 14.2847 0.05)
set_property(TEST ${THIS_TEST_NAME}_WARP_METRIC_0 APPEND PROPERTY DEPENDS ${THIS_TEST_NAME}_WARP)

add_test(${THIS_TEST_NAME}_WARP_METRIC_1 ${TEST_BINARY_DIR}/MeasureImageSimilarity 2 1
 ${R16_IMAGE} ${WARP_IMAGE} ${OUTPUT_PREFIX}log.txt
 ${OUTPUT_PREFIX}metric.nii.gz
 9.996276 0.05)
set_property(TEST ${THIS_TEST_NAME}_WARP_METRIC_1 APPEND PROPERTY DEPENDS ${THIS_TEST_NAME}_WARP)

add_test(${THIS_TEST_NAME}_WARP_METRIC_2 ${TEST_BINARY_DIR}/MeasureImageSimilarity 2 2
 ${R16_IMAGE} ${WARP_IMAGE} ${OUTPUT_PREFIX}log.txt
 ${OUTPUT_PREFIX}metric.nii.gz
 -1.19298 0.05)
set_property(TEST ${THIS_TEST_NAME}_WARP_METRIC_2 APPEND PROPERTY DEPENDS ${THIS_TEST_NAME}_WARP)

add_test(${THIS_TEST_NAME}_INVERSEWARP ${TEST_BINARY_DIR}/WarpImageMultiTransform 2
 ${R16_IMAGE} ${INVERSEWARP_IMAGE} ${INVERSEWARP} -R ${R16_IMAGE}
 )
set_property(TEST ${THIS_TEST_NAME}_INVERSEWARP APPEND PROPERTY DEPENDS ${THIS_TEST_NAME})

add_test(${THIS_TEST_NAME}_JPGINV ${TEST_BINARY_DIR}/ConvertToJpg ${INVERSEWARP_IMAGE} ${THIS_TEST_NAME}INV.jpg)
set_property(TEST ${THIS_TEST_NAME}_JPGINV APPEND PROPERTY DEPENDS ${THIS_TEST_NAME}_INVERSEWARP)

add_test(${THIS_TEST_NAME}_INVERSEWARP_METRIC_0
 ${TEST_BINARY_DIR}/MeasureImageSimilarity 2 0 ${R64_IMAGE}
 ${INVERSEWARP_IMAGE} ${OUTPUT_PREFIX}log.txt ${OUTPUT_PREFIX}metric.nii.gz
 50.4483 0.05)
set_property(TEST ${THIS_TEST_NAME}_INVERSEWARP_METRIC_0 APPEND PROPERTY DEPENDS ${THIS_TEST_NAME}_INVERSEWARP)

add_test(${THIS_TEST_NAME}_INVERSEWARP_METRIC_1
 ${TEST_BINARY_DIR}/MeasureImageSimilarity 2 1 ${R64_IMAGE}
 ${INVERSEWARP_IMAGE} ${OUTPUT_PREFIX}log.txt ${OUTPUT_PREFIX}metric.nii.gz
 1.0 0.05)
set_property(TEST ${THIS_TEST_NAME}_INVERSEWARP_METRIC_1 APPEND PROPERTY DEPENDS ${THIS_TEST_NAME}_INVERSEWARP)

add_test(${THIS_TEST_NAME}_INVERSEWARP_METRIC_2
 ${TEST_BINARY_DIR}/MeasureImageSimilarity 2 2 ${R64_IMAGE}
 ${INVERSEWARP_IMAGE} ${OUTPUT_PREFIX}log.txt ${OUTPUT_PREFIX}metric.nii.gz
 0.379897 0.05)
set_property(TEST ${THIS_TEST_NAME}_INVERSEWARP_METRIC_2 APPEND PROPERTY DEPENDS ${THIS_TEST_NAME}_INVERSEWARP)

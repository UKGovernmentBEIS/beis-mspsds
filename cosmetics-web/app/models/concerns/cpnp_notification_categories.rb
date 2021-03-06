module CpnpNotificationCategories
  def get_category(id)
    CATEGORY_ID[id]
  end

  CATEGORY_ID = {
    100_003 => :skin_products,
    100_004 => :skin_care_products,
    100_005 => :face_care_products_other_than_face_mask,
    100_018 => :face_mask,
    100_025 => :eye_contour_products,
    100_032 => :lip_care_products,
    100_035 => :hand_care_products,
    100_044 => :foot_care_products,
    100_049 => :body_care_products,
    100_062 => :external_intimate_care_products,
    100_064 => :chemical_exfoliation_products,
    100_067 => :mechanical_exfoliation_products,
    100_071 => :skin_lightening_products,
    100_079 => :other_skin_care_products,
    100_087 => :skin_cleansing_products,
    100_088 => :soap_products,
    100_092 => :bath_shower_products,
    100_101 => :makeup_remover_products,
    100_105 => :external_intimate_hygiene_products,
    100_108 => :other_skin_cleansing_products,
    100_116 => :body_hair_removal_products,
    100_117 => :chemical_depilatories,
    100_120 => :physical_epilation_products,
    100_124 => :other_body_hair_removal_products,
    100_126 => :bleach_for_body_hair_products,
    100_127 => :bleach_for_body_hair,
    100_130 => :correction_of_body_odour_andor_perspiration,
    100_131 => :products_with_antiperspirant_activity,
    100_138 => :products_without_antiperspirant_activity,
    100_144 => :shaving_and_pre_after_shaving_products,
    100_145 => :shaving_products,
    100_153 => :pre_aftershaving_products,
    100_157 => :other_shaving_and_pre_after_shaving_products,
    100_159 => :makeup_products,
    100_160 => :foundation,
    100_165 => :concealer,
    100_171 => :other_face_makeup_products,
    100_173 => :mascara,
    100_178 => :eye_shadow,
    100_183 => :eye_pencil,
    100_186 => :eye_liner,
    100_192 => :other_eye_makeup_products,
    100_196 => :lip_stick,
    100_199 => :lipstick_sealer,
    100_202 => :other_lip_makeup_products,
    100_210 => :body_or_face_paint_including_carneval_makeup,
    100_213 => :other_makeup_products,
    100_221 => :perfumes,
    100_222 => :hydroalcoholic_perfumes,
    100_225 => :non_hydroalcoholic_perfumes,
    100_230 => :sun_and_selftanning_products,
    100_231 => :before_and_after_sun_products,
    100_239 => :sun_protection_products,
    100_246 => :selftanning_products,
    100_250 => :other_sun_and_selftanning_products,
    100_252 => :other_skin_products,
    100_253 => :other_skin_products_child,
    100_255 => :hair_and_scalp_products,
    100_256 => :hair_and_scalp_care_and_cleansing_products,
    100_257 => :shampoo,
    100_262 => :hair_conditioner,
    100_268 => :scalp_and_hair_roots_care_products,
    100_272 => :antidandruff_products,
    100_278 => :antihairloss_products,
    100_282 => :other_hair_and_scalp_care_and_cleansing_products,
    100_284 => :hair_colouring_products,
    100_285 => :oxidative_hair_colour_products,
    100_293 => :nonoxidative_hair_colour_products,
    100_298 => :hair_bleaching_and_dye_remover_products,
    100_310 => :other_hair_colouring_products,
    100_312 => :hair_styling_products,
    100_313 => :products_for_temporary_hair_styling,
    100_324 => :permanent_wave_products,
    100_332 => :hair_relaxer_straightener_products,
    100_338 => :other_hair_styling_products,
    100_340 => :other_hair_and_scalp_products,
    100_341 => :hair_sun_protection_products,
    100_347 => :other_hair_and_scalp_products_child,
    100_349 => :nail_and_cuticle_products,
    100_350 => :nail_varnish_and_remover_products,
    100_351 => :nail_varnish_nail_makeup,
    100_355 => :nail_varnish_remover,
    100_357 => :nail_varnish_thinner,
    100_359 => :nail_bleach,
    100_361 => :other_nail_varnish_and_remover_products,
    100_363 => :nail_care_nail_hardener_products,
    100_364 => :nail_care_products,
    100_367 => :nail_hardener,
    100_369 => :other_nail_care_nail_hardener_products,
    100_371 => :nail_glue_remover_products,
    100_372 => :nail_glue_remover,
    100_374 => :other_nail_and_cuticle_products,
    100_375 => :cuticle_remover_softener,
    100_377 => :nail_sculpting_products,
    100_379 => :other_nail_and_cuticle_products_child,
    100_381 => :oral_hygiene_products,
    100_382 => :tooth_care_products,
    100_383 => :toothpaste,
    100_386 => :tooth_cleansing_powder_salt,
    100_388 => :other_tooth_care_products,
    100_390 => :mouth_wash_breath_spray,
    100_391 => :mouth_wash,
    100_395 => :breath_spray,
    100_398 => :other_mouth_wash_breath_spray_products,
    100_400 => :tooth_whiteners,
    100_401 => :tooth_whiteners_child,
    100_403 => :other_oral_hygiene_products,
    100_404 => :other_oral_hygiene_products_child,
  }.freeze
end

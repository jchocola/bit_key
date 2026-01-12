// ignore_for_file: constant_identifier_names

enum AppException {
  passwords_do_not_match,
  invalid_master_key,
  empty_key,
  cannot_auth_via_local_auth,

  ///
  /// FOLDER
  ///
  failed_to_create_folder,
  folder_already_exist,
  folder_not_exist,
  item_name_cannot_be_empty,
  failed_to_delete_folder,
  failed_to_add_list_folder,

  ///
  /// HIVE DB
  ///
  failed_to_delete_card,
  failed_to_delete_identity,
  failed_to_delete_login,

  failed_to_save_login,
  failed_to_save_card,
  failed_to_save_identity,

  failed_to_updated_login,
  failed_to_updated_card,
  failed_to_updated_identity,

  failed_to_move_login_to_bin,
  failed_to_move_card_to_bin,
  failed_to_move_identity_to_bin,

  failed_to_restore_card,
  failed_to_restore_login,
  failed_to_restore_identity,

  card_not_exist_in_box,
  identity_not_exist_in_box,
  login_not_exist_in_box,

  failed_to_delete_all_card_from_bin,
  failed_to_delete_all_login_from_bin,
  failed_to_delete_all_identity_from_bin,

  failed_to_delete_all_cards,
  failed_to_delete_all_logins,
  failed_to_delete_all_identities,

  failed_to_save_card_list,
  failed_to_save_login_list,
  failed_to_save_identity_list,

  ///
  /// ENCRYPTION
  ///
  failed_to_decrypt_str,
  failed_to_encrypt_str,
  failed_to_convert_key_to_valid_for_use,

  failed_to_decrypt_card,
  failed_to_decrypt_login,
  failed_to_decrypt_identity,

  failed_to_encrypt_card,
  failed_to_encrypt_login,
  failed_to_encrypt_identity,

  ///
  /// SECURE STORAGE
  ///
  failed_to_delete_hashed_master_key,
  failed_to_delete_salt,
  failed_to_delete_session_key,

  failed_to_get_hashed_master_key,
  failed_to_get_salt,
  failed_to_get_session_key,

  failed_to_set_hashed_master_key,
  failed_to_set_salt,
  failed_to_set_session_key,

  failed_to_clear_all_secure_data,
  failed_to_generate_salt,
  failed_to_check_validity_master_key,

  failed_to_delete_encrypted_master_key,
  failed_to_get_encrypted_master_key,
  failed_to_set_encrypted_master_key,

  failed_to_generate_hashed_master_key,
  failed_to_generate_session_key,
  failed_to_generate_encrypted_master_key,

  failed_to_decrypt_encrypted_master_key,

  ///
  /// URL LAUNCHER
  ///
  failed_to_contact_developer,
  failed_to_launch_url,

  ///
  /// APP SECURITY
  ///
  failed_to_change_clean_key_duration,
  failed_to_change_session_timeout,
  failed_to_toogle_allow_screenshot_value,
  failed_to_toogle_shake_to_lock,

  // LOCAL AUTH
  device_not_supported_local_auth,
  no_biometric_enrolled,

}

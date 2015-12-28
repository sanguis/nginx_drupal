nginx_drupal_drupal_instance [ 'example.dev' ]  do
  url [ "www.test.dev", "example.dev" ]
  #ssl_crt 
  #ssl_key 
  #ssl_chain 
  passwd [ "knectar:$apr1$KcTN/KIC$2pWUIc.Xi8q4pWKXQNT3z." ]
  #passwd_text 
  #app_path 
  #public_files 
  #private_files 
  app_owner 'sites' 
end

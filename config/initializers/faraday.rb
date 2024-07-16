Faraday.default_connection = Faraday.new do |conn|
  conn.ssl[:verify] = true
  # If using a self-signed certificate, you may need to specify the CA file path.
  # conn.ssl[:ca_file] = 'path/to/ca_cert.pem'
end

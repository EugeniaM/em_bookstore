def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: "facebook",
    uid: "12345678910",
    info: {
      email: "test@yopmail.com",
      first_name: "Test",
      image: "http://graph.facebook.com/v2.6/12345678910/picture",
      last_name: "Testtest"
    },
    credentials: {
      expires: true,
      token: "abcdefg12345",
      expires_at: DateTime.now,
    }
  })
end
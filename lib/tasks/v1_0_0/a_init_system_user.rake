namespace :v1_0_0 do
  task a_init_system_user: :environment do
    puts 'Begin initialize a system user'
    user_attributes = { name: 'system user', email: 'system_user@example.com', password: '11111111', activated: true, activated_at: Time.current }
    user = User.new(user_attributes)
    user.save(validate: false)
    puts 'Begin initialize a system user'
  end
end

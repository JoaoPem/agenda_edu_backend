User.create!(
  [
    {
      name: 'João Pedro Monteiro',
      email: 'JOAO@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :admin
    },
    {
      name: 'Mateus Monteiro',
      email: 'mateus@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :professor
    },
    {
      name: 'Isadora Neves',
      email: 'Isadora@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :student
    }
  ]
)

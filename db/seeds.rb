User.create!(
  [
    {
      name: 'Diretor',
      email: 'diretor@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :admin
    },
    {
      name: 'Sub-Diretor',
      email: 'subdiretor@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :admin
    },
    {
      name: 'Professor 01',
      email: 'professor1@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :professor
    },
    {
      name: 'Professor 02',
      email: 'professor2@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :professor
    },
    {
      name: 'Aluno 01',
      email: 'aluno1@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :student
    },
    {
      name: 'Aluno 02',
      email: 'aluno2@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :student
    },
    {
      name: 'Aluno 03',
      email: 'aluno3@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :student
    },
    {
      name: 'Pai 01',
      email: 'pai1@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :parent
    },
    {
      name: 'Pai 02',
      email: 'pai2@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :parent
    },
    {
      name: 'Pai 03',
      email: 'pai3@test.com',
      password: 'Abcd@123',
      password_confirmation: "Abcd@123",
      role: :parent
    }
  ]
)

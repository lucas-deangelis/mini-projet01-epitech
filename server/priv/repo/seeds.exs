# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gotham.Repo.insert!(%Gotham.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Gotham.Accounts.{User, Team}
alias Gotham.Times.{Clock, Workingtime}
alias Gotham.Repo

# On vide les tables de leur contenu pour repartir de 0 pour les tests
# Le cascade permet de viser les autres tables qui référencent users
Repo.query("TRUNCATE TABLE users CASCADE", [])

# Ici on remet à zéro les sequences (compteurs utilisés pour les IDs)
Repo.query("ALTER SEQUENCE users_id_seq RESTART")
Repo.query("ALTER SEQUENCE clocks_id_seq RESTART")
Repo.query("ALTER SEQUENCE workingtimes_id_seq RESTART")
Repo.query("ALTER SEQUENCE teams_id_seq RESTART")

# Insert some users
%User{
    username: "joerogan",
    email: "joe.rogan@email.com",
    role: "admin",
    password_hash: Argon2.hash_pwd_salt("admin")
}
|> Repo.insert!()

%User{
    username: "peterattia",
    email: "peter.attia@email.com",
    role: "manager",
    password_hash: Argon2.hash_pwd_salt("manager")

}
|> Repo.insert!()

%User{
    username: "timferriss",
    email: "tim.ferriss@email.com",
    role: "employee",
    password_hash: Argon2.hash_pwd_salt("employee")

}
|> Repo.insert!()

%User{
    username: "toto",
    email: "toto@email.com",
    role: "employee",
    password_hash: Argon2.hash_pwd_salt("employee")

}
|> Repo.insert!()

%User{
    username: "tutu",
    email: "tutu@email.com",
    role: "employee",
    password_hash: Argon2.hash_pwd_salt("employee")

}
|> Repo.insert!()

%User{
    username: "tata",
    email: "tata@email.com",
    role: "employee",
    password_hash: Argon2.hash_pwd_salt("employee")

}
|> Repo.insert!()

%User{
    username: "titi",
    email: "titi@email.com",
    role: "employee",
    password_hash: Argon2.hash_pwd_salt("employee")

}
|> Repo.insert!()

# Insert some working times
%Workingtime{
    start: ~N[2019-09-09 09:30:00],
    end: ~N[2019-09-09 12:30:00],
    user_id: 1
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-09 13:30:00],
    end: ~N[2019-09-09 17:30:00],
    user_id: 1
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-10 09:30:00],
    end: ~N[2019-09-10 12:30:00],
    user_id: 1
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-10 13:30:00],
    end: ~N[2019-09-10 17:30:00],
    user_id: 1
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-09 09:30:00],
    end: ~N[2019-09-09 13:30:00],
    user_id: 2
}
|> Repo.insert!()

# Insert some clocks
%Clock{
    time: ~N[2019-09-12 09:30:00],
    status: true,
    user_id: 1
}
|> Repo.insert!()

%Clock{
    time: ~N[2019-09-11 17:30:00],
    status: false,
    user_id: 3
}
|> Repo.insert!()

# Insert some teams
%Team{
    name: "Accountant",
    manager_id: 2
}
|> Repo.insert!()

Repo.insert_all("users_teams", [
    [user_id: 3, team_id: 1],
    [user_id: 4, team_id: 1],
    [user_id: 5, team_id: 1],
])

%Team{
    name: "Devs",
    manager_id: 2
}
|> Repo.insert!()

Repo.insert_all("users_teams", [
    [user_id: 6, team_id: 2],
    [user_id: 7, team_id: 2],
])

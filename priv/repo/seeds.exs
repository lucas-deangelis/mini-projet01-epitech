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

alias Gotham.Accounts.User
alias Gotham.Times.{Clock, Workingtime}
alias Gotham.Repo

# On vide les tables de leur contenu pour repartir de 0 pour les tests
# Le cascade permet de viser les deux autres tables qui référencent users 
Repo.query("TRUNCATE TABLE users CASCADE", [])

# Ici on remet à zéro les sequences (compteurs utilisés pour les IDs)
Repo.query("ALTER SEQUENCE users_id_seq RESTART")
Repo.query("ALTER SEQUENCE clocks_id_seq RESTART")
Repo.query("ALTER SEQUENCE workingtimes_id_seq RESTART")


%User{
    username: "joerogan",
    email: "joe.rogan@mail.com"
}
|> Repo.insert!()

%User{
    username: "peterattia",
    email: "peter.attia@mail.com"
}
|> Repo.insert!()

%User{
    username: "timferriss",
    email: "tim.ferriss@mail.com"
}
|> Repo.insert!()


%Workingtime{
    start: ~N[2019-09-09 09:30:00],
    end: ~N[2019-09-09 12:30:00],
    user: 1 
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-09 13:30:00],
    end: ~N[2019-09-09 17:30:00],
    user: 1 
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-10 09:30:00],
    end: ~N[2019-09-10 12:30:00],
    user: 1 
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-10 13:30:00],
    end: ~N[2019-09-10 17:30:00],
    user: 1 
}
|> Repo.insert!()

%Workingtime{
    start: ~N[2019-09-09 09:30:00],
    end: ~N[2019-09-09 13:30:00],
    user: 2
}
|> Repo.insert!()


%Clock{
    time: ~N[2019-09-12 09:30:00],
    status: true,
    user: 1
}
|> Repo.insert!()

%Clock{
    time: ~N[2019-09-11 17:30:00],
    status: false,
    user: 2
}
|> Repo.insert!()
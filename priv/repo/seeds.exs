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
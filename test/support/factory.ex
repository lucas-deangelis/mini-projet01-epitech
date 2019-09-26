defmodule Gotham.Factory do
  alias Gotham.Repo

  # Factories

  def build(:workingtime) do
    %Gotham.Times.Workingtime{
      start: DateTime.now(),
      end: DateTime.add(DateTime.now(), 25200),
      user: build(:user)
    }
  end

  def build(:user) do
    %Gotham.Accounts.User{
      email: "hello#{System.unique_integer()}",
      username: "hello#{System.unique_integer()}",
      role: "employee",
      password_hash: Argon2.hash_pwd_salt("employee")
    }
  end

  def build(:clock) do
    %Gotham.Times.Clock{
      time: DateTime.now(),
      status: true,
      user: build(:user)
    }
  end


  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    Repo.insert! build(factory_name, attributes)
  end
end

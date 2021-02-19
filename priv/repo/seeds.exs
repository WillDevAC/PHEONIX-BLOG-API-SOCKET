# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blog.{Accounts, Accounts, Posts}

user = %{
  email: "elixirproedugu@gmail.com",
  first_name: nil,
  image:
    "https://lh5.googleusercontent.com/-6jn5VKVJbhc/AAAAAAAAAAI/AAAAAAAAAAA/3hDKgJz7Zs8/photo.jpg",
  last_name: nil,
  provider: "google",
  token:
    "ya29.a0AfH6SMBwEyYfefc2DUrCMnbKXUMG048p2zLTnDidWzGs6-PCDfoIrIg2AZXfFft2vFpVW_sqNoqCe51cKaVJEaU1Upv61ZPZQXtjexp10KC372KN2c-ryN821diQlzncMeIaOXaC_1XKlfSgpKC-DsGXgRP9Jf1n69o"
}

user_2 = %{
  email: "23424324@gmail.com",
  first_name: nil,
  image: "https://lh5.43443.com/-6jn5VKVJbhc/AAAAAAAAAAI/AAAAAAAAAAA/3hDKgJz7Zs8/photo.jpg",
  last_name: nil,
  provider: "google",
  token:
    "ya29.4343434-PCDfoIrIg2AZXfFft2vFpVW_sqNoqCe51cKaVJEaU1Upv61ZPZQXtjexp10KC372KN2c-ryN821diQlzncMeIaOXaC_1XKlfSgpKC-DsGXgRP9Jf1n69o"
}

post = %{
  title: "PG",
  description:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
}

{:ok, user} = Accounts.create_user(user)
{:ok, _user_2} = Accounts.create_user(user_2)

{:ok, _phoenix} = Posts.create_post(user, post)

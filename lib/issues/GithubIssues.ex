defmodule Issues.GithubIssues
do
  @user_agent [{"User-agent","Elixir dave@pragprog.com"}]
  def fetch(user,project)
  do
    issues_url(user,project)
    |>HTTPoison.get(@user_agent)
    |>get_response
    |>handle_response
  end
  def get_response({status,response}), do: response
  def issues_url(user,project)
  do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end
  def handle_response(%{status_code: 200,body: body}) ,do: {:ok,:jsx.decode(body)}
  def handle_response(%{status_code: _,body: body}) ,do: {:error,:jsx.decode(body)}
end

defmodule DailyWeb.LayoutView do
  use DailyWeb, :view

  alias Plug.Conn
  alias Daily.Users.User

  def logged_in?(conn), do: Map.get(conn.assigns, :current_user) != nil

  def page_title(%Conn{assigns: %{page_title: page_title}}), do: ["Daily · ", page_title]
  def page_title(_otherwise), do: "Daily"

  def full_name(%User{first_name: f, last_name: l}), do: f <> " " <> l
  def full_name(%User{first_name: first_name}), do: first_name
  def full_name(_otherwise), do: nil

  def initials(%User{first_name: f, last_name: l}), do: String.first(f) <> String.first(l)
  def initials(%User{first_name: first_name}), do: String.slice(first_name, 0..1)
  def initials(%User{email: email}), do: String.slice(email, 0..1)

  def classes(:link, selected: true), do: "inline-flex items-center px-1 pt-1 border-b-2 border-indigo-500 text-sm font-medium leading-5 text-gray-900 focus:outline-none focus:border-indigo-700 transition duration-150 ease-in-out"
  def classes(:link, selected: false), do: "inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium leading-5 text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-300 transition duration-150 ease-in-out"
  def classes(:mobile_link, selected: true), do: "block pl-3 pr-4 py-2 border-l-4 border-indigo-500 text-base font-medium text-indigo-700 bg-indigo-50 focus:outline-none focus:text-indigo-800 focus:bg-indigo-100 focus:border-indigo-700 transition duration-150 ease-in-out"
  def classes(:mobile_link, selected: false), do: "block pl-3 pr-4 py-2 border-l-4 border-transparent text-base font-medium text-gray-600 hover:text-gray-800 hover:bg-gray-50 hover:border-gray-300 focus:outline-none focus:text-gray-800 focus:bg-gray-50 focus:border-gray-300 transition duration-150 ease-in-out"
end

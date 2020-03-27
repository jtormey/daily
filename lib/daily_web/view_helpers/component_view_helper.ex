defmodule DailyWeb.ComponentViewHelper do
  import Phoenix.View, only: [render: 3]

  alias Plug.Conn
  alias DailyWeb.ComponentView, as: View

  def component(:header, do: c), do: render(View, "header.html", children: c)

  def component(:flashes, conn = %Conn{}), do: render(View, "flashes.html", conn: conn)
end

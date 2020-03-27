defmodule DailyWeb.ComponentViewHelper do
  import Phoenix.View, only: [render: 3]

  alias DailyWeb.ComponentView, as: View

  def component(:header, do: c), do: render(View, "header.html", children: c)
end

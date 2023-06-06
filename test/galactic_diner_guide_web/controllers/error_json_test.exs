defmodule GalacticDinerGuideWeb.ErrorJSONTest do
  use GalacticDinerGuideWeb.ConnCase, async: true

  test "renders 404" do
    assert GalacticDinerGuideWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert GalacticDinerGuideWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

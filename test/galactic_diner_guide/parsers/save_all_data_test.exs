defmodule GalacticDinerGuide.Parsers.SaveAllDataTest do
  use ExUnit.Case, async: true
  use GalacticDinerGuide.DataCase, async: true

  alias GalacticDinerGuide.Parsers.SaveAllData

  @moduletag timeout: :infinity

  describe "call/1" do
    test "saves all data in transactions" do
      response = SaveAllData.call("data.csv")

      expected_response = {:ok, "All Data successfully inserted in database"}

      assert response == expected_response
    end
  end
end

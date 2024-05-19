defmodule MinettiFw.StateTest do
  use ExUnit.Case

  alias MinettiFw.State

  describe "temperature_up/1" do
    test "increases temperature" do
      state = %State{temperature: 23.5}
      assert %State{temperature: 24} == State.temperature_up(state)
    end

    test "doesn't increase temperature beyond limit" do
      state = %State{temperature: 30}
      assert %State{temperature: 30} == State.temperature_up(state)
    end
  end

  describe "temperature_down/1" do
    test "decreases temperature" do
      state = %State{temperature: 23.5}
      assert %State{temperature: 23} == State.temperature_down(state)
    end

    test "doesn't decrease temperature beyond limit" do
      state = %State{temperature: 16}
      assert %State{temperature: 16} == State.temperature_down(state)
    end
  end
end

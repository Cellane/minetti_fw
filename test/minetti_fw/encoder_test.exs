defmodule MinettiFw.EncoderTest do
  use ExUnit.Case

  alias MinettiFw.{Encoder, State}

  describe "encode/1 with temperature" do
    test "encodes cool/16°C/auto correctly" do
      state = %State{mode: :cool, temperature: 16, fan_speed: :auto}

      assert "S110000100011110110111111010000000000000011111111TS110000100011110110111111010000000000000011111111TS110101010110011000000000000100000000001001001101T" =
               Encoder.encode(state)
    end

    test "encodes cool/17°C/auto correctly" do
      state = %State{mode: :cool, temperature: 17, fan_speed: :auto}

      assert "S110000100011110110111111010000000000000011111111TS110000100011110110111111010000000000000011111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/18°C/auto correctly" do
      state = %State{mode: :cool, temperature: 18, fan_speed: :auto}

      assert "S110000100011110110111111010000000001000011101111TS110000100011110110111111010000000001000011101111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/19°C/auto correctly" do
      state = %State{mode: :cool, temperature: 19, fan_speed: :auto}

      assert "S110000100011110110111111010000000011000011001111TS110000100011110110111111010000000011000011001111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/20°C/auto correctly" do
      state = %State{mode: :cool, temperature: 20, fan_speed: :auto}

      assert "S110000100011110110111111010000000010000011011111TS110000100011110110111111010000000010000011011111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/21°C/auto correctly" do
      state = %State{mode: :cool, temperature: 21, fan_speed: :auto}

      assert "S110000100011110110111111010000000110000010011111TS110000100011110110111111010000000110000010011111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/22°C/auto correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto}

      assert "S110000100011110110111111010000000111000010001111TS110000100011110110111111010000000111000010001111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/22.5°C/auto correctly" do
      state = %State{mode: :cool, temperature: 22.5, fan_speed: :auto}

      assert "S110000100011110110111111010000000111000010001111TS110000100011110110111111010000000111000010001111TS110101010110011000100000000000000000001001011101T" =
               Encoder.encode(state)
    end

    test "encodes cool/23°C/auto correctly" do
      state = %State{mode: :cool, temperature: 23, fan_speed: :auto}

      assert "S110000100011110110111111010000000101000010101111TS110000100011110110111111010000000101000010101111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/24°C/auto correctly" do
      state = %State{mode: :cool, temperature: 24, fan_speed: :auto}

      assert "S110000100011110110111111010000000100000010111111TS110000100011110110111111010000000100000010111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/25°C/auto correctly" do
      state = %State{mode: :cool, temperature: 25, fan_speed: :auto}

      assert "S110000100011110110111111010000001100000000111111TS110000100011110110111111010000001100000000111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/26°C/auto correctly" do
      state = %State{mode: :cool, temperature: 26, fan_speed: :auto}

      assert "S110000100011110110111111010000001101000000101111TS110000100011110110111111010000001101000000101111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/27°C/auto correctly" do
      state = %State{mode: :cool, temperature: 27, fan_speed: :auto}

      assert "S110000100011110110111111010000001001000001101111TS110000100011110110111111010000001001000001101111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/28°C/auto correctly" do
      state = %State{mode: :cool, temperature: 28, fan_speed: :auto}

      assert "S110000100011110110111111010000001000000001111111TS110000100011110110111111010000001000000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/29°C/auto correctly" do
      state = %State{mode: :cool, temperature: 29, fan_speed: :auto}

      assert "S110000100011110110111111010000001010000001011111TS110000100011110110111111010000001010000001011111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes cool/30°C/auto correctly" do
      state = %State{mode: :cool, temperature: 30, fan_speed: :auto}

      assert "S110000100011110110111111010000001011000001001111TS110000100011110110111111010000001011000001001111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end
  end

  describe "encode/1 with on timer" do
  end

  describe "encode/1 with off timer" do
  end

  describe "encode/1 with fan speed" do
    test "encodes cool/22°C/quiet correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :quiet}

      assert "S110000100011110111111111000000000111000010001111TS110000100011110111111111000000000111000010001111TS110101010000000100000000000000000000001011011000T" =
               Encoder.encode(state)
    end

    test "encodes cool/22°C/low correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :low}

      assert "S110000100011110110011111011000000111000010001111TS110000100011110110011111011000000111000010001111TS110101010010100000000000000000000000001011111111T" =
               Encoder.encode(state)
    end

    test "encodes cool/22°C/weak correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :weak}

      assert "S110000100011110101011111101000000111000010001111TS110000100011110101011111101000000111000010001111TS110101010011110000000000000000000000001000010011T" =
               Encoder.encode(state)
    end

    test "encodes cool/22°C/strong correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :strong}

      assert "S110000100011110100111111110000000111000010001111TS110000100011110100111111110000000111000010001111TS110101010101000000000000000000000000001000100111T" =
               Encoder.encode(state)
    end

    test "encodes cool/22°C/super correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :super}

      assert "S110000100011110100111111110000000111000010001111TS110000100011110100111111110000000111000010001111TS110101010110010000000000000000100000001000111101T" =
               Encoder.encode(state)
    end
  end

  describe "encode/1 with modes" do
    test "encodes heat/22°C/auto correctly" do
      state = %State{mode: :heat, temperature: 22, fan_speed: :auto}

      assert "S110000100011110110111111010000000111110010000011TS110000100011110110111111010000000111110010000011TS110101010110011000000000000000000000000000111011T" =
               Encoder.encode(state)
    end

    test "encodes dry/22°C/auto correctly" do
      state = %State{mode: :dry, temperature: 22, fan_speed: :auto}

      assert "S110000100011110100011111111000000111010010001011TS110000100011110100011111111000000111010010001011TS110101010110010100000000000000000000000000111010T" =
               Encoder.encode(state)
    end

    test "encodes auto/22°C/auto correctly" do
      state = %State{mode: :auto, temperature: 22, fan_speed: :auto}

      assert "S110000100011110100011111111000000111100010000111TS110000100011110100011111111000000111100010000111TS110101010110010100000000000000000000000000111010T" =
               Encoder.encode(state)
    end

    test "encodes fan only/22°C/auto correctly" do
      state = %State{mode: :fan_only, temperature: 22, fan_speed: :auto}

      assert "S110000100011110110111111010000001110010000011011TS110000100011110110111111010000001110010000011011TS110101010110011000000000000000000000000000111011T" =
               Encoder.encode(state)
    end

    test "encodes stop correctly" do
      state = %State{mode: :off}

      assert "S110000100011110101111011100001001110000000011111TS110000100011110101111011100001001110000000011111T" =
               Encoder.encode(state)
    end
  end

  describe "encode/1 with special commands" do
    test "encodes swing correctly" do
      assert "S110000100011110101101011100101001110000000011111TS110000100011110101101011100101001110000000011111T" =
               Encoder.encode(:swing)
    end

    test "encodes vertical direction correctly" do
      assert "S110010010011011011110101000010100010110011010011TS110010010011011011110101000010100010110011010011T" =
               Encoder.encode(:vertical_direction)
    end
  end

  describe "invert/1" do
    test "inverts a bitstring" do
      assert "11110000" == Encoder.invert("00001111")
    end
  end
end

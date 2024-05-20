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

  describe "encode/1/ with on timer" do
  end

  describe "encode/1 with off timer" do
    test "encodes 30 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 30}

      assert "S110000100011110110100001010111100111000001111111TS110000100011110110100001010111100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 60 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 60}

      assert "S110000100011110110100011010111000111000001111111TS110000100011110110100011010111000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 90 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 90}

      assert "S110000100011110110100101010110100111000001111111TS110000100011110110100101010110100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 120 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 120}

      assert "S110000100011110110100111010110000111000001111111TS110000100011110110100111010110000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 150 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 150}

      assert "S110000100011110110101001010101100111000001111111TS110000100011110110101001010101100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 180 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 180}

      assert "S110000100011110110101011010101000111000001111111TS110000100011110110101011010101000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 210 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 210}

      assert "S110000100011110110101101010100100111000001111111TS110000100011110110101101010100100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 240 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 240}

      assert "S110000100011110110101111010100000111000001111111TS110000100011110110101111010100000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 270 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 270}

      assert "S110000100011110110110001010011100111000001111111TS110000100011110110110001010011100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 300 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 300}

      assert "S110000100011110110110011010011000111000001111111TS110000100011110110110011010011000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 330 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 330}

      assert "S110000100011110110110101010010100111000001111111TS110000100011110110110101010010100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 360 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 360}

      assert "S110000100011110110110111010010000111000001111111TS110000100011110110110111010010000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 390 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 390}

      assert "S110000100011110110111001010001100111000001111111TS110000100011110110111001010001100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 420 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 420}

      assert "S110000100011110110111011010001000111000001111111TS110000100011110110111011010001000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 450 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 450}

      assert "S110000100011110110111101010000100111000001111111TS110000100011110110111101010000100111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 480 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 480}

      assert "S110000100011110110111111010000000111000001111111TS110000100011110110111111010000000111000001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 510 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 510}

      assert "S110000100011110110100001010111100111000101111111TS110000100011110110100001010111100111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 540 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 540}

      assert "S110000100011110110100011010111000111000101111111TS110000100011110110100011010111000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 570 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 570}

      assert "S110000100011110110100101010110100111000101111111TS110000100011110110100101010110100111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 600 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 600}

      assert "S110000100011110110100111010110000111000101111111TS110000100011110110100111010110000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 660 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 660}

      assert "S110000100011110110101011010101000111000101111111TS110000100011110110101011010101000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 720 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 720}

      assert "S110000100011110110101111010100000111000101111111TS110000100011110110101111010100000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 780 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 780}

      assert "S110000100011110110110011010011000111000101111111TS110000100011110110110011010011000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 840 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 840}

      assert "S110000100011110110110111010010000111000101111111TS110000100011110110110111010010000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 900 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 900}

      assert "S110000100011110110111011010001000111000101111111TS110000100011110110111011010001000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 960 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 960}

      assert "S110000100011110110111111010000000111000101111111TS110000100011110110111111010000000111000101111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1020 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1020}

      assert "S110000100011110110100011010111000111001001111111TS110000100011110110100011010111000111001001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1080 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1080}

      assert "S110000100011110110100111010110000111001001111111TS110000100011110110100111010110000111001001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1140 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1140}

      assert "S110000100011110110101011010101000111001001111111TS110000100011110110101011010101000111001001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1200 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1200}

      assert "S110000100011110110101111010100000111001001111111TS110000100011110110101111010100000111001001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1260 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1260}

      assert "S110000100011110110110011010011000111001001111111TS110000100011110110110011010011000111001001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1320 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1320}

      assert "S110000100011110110110111010010000111001001111111TS110000100011110110110111010010000111001001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1380 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1380}

      assert "S110000100011110110111011010001000111001001111111TS110000100011110110111011010001000111001001111111TS110101010110011000000000000000000000001000111101T" =
               Encoder.encode(state)
    end

    test "encodes 1440 minutes off timer correctly" do
      state = %State{mode: :cool, temperature: 22, fan_speed: :auto, off_timer: 1440}

      assert "S110000100011110110111111010000000111001001111111TS110000100011110110111111010000000111001001111111TS110101010110011000000000000000000000001000111101T" =
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

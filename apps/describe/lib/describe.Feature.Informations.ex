defmodule Describe.Feature.Informations do

    alias Describe.Feature.Informations

    defstruct name: nil, count: 0.0, mean: 0.0, std: 0.0, min: 0.0, "25%": 0.0, "50%": 0.0, "75%": 0.0, max: 0.0, range: 0.0

    def new_from(list, name) do
        {count, mean, min, max} = get(list)
        sorted_list = Enum.sort(list)
        %Informations{
            name: name,
            count: count / 1,
            mean: mean,
            std: get_std(list, mean),
            min: min,
            "25%": get_quartile(sorted_list, count, 25),
            "50%": get_quartile(sorted_list, count, 50),
            "75%": get_quartile(sorted_list, count, 75),
            max: max,
            range: max - min
        }
    end

    defp get(list, count \\ 0, total \\ 0, min \\ nil, max \\ nil)
    defp get([:missing | tail], count, total, min, max) do
      get tail, count, total, min, max
    end
    defp get([head | tail], count, total, nil, nil) do
      get tail, count + 1, total + head, head, head
    end
    defp get([head | tail], count, total, min, max) do
      get tail, count + 1, total + head, get_min(head, min), get_max(head, max)
    end
    defp get([], count, total, min, max) do
      {
          count,
          total / count,
          min,
          max,
      }
  end

    defp get_max(num1, num2) when num1 > num2 do num1 end
    defp get_max(_num1, num2), do: num2

    defp get_min(num1, num2) when num1 < num2 do num1 end
    defp get_min(_num1, num2), do: num2
    # defp get([:missing, tail], count, total, min, max) do
    #     get(tail, count, total, min, max)
    # end
    # defp get([head | tail], count, total, nil, nil) do
    #     get(tail, count + 1, total + head, head, head)
    # end
    # defp get([:missing = head | tail], count, total, min, max) when head < min do
    #     get(tail, count, total, min, max)
    # end
    # defp get([head | tail], count, total, min, max) when head < min do
    #     get(tail, count + 1, total + head, head, max)
    # end
    # defp get([:missing = head | tail], count, total, min, max) when head > max do
    #     get(tail, count, total, min, max)
    # end
    # defp get([head | tail], count, total, min, max) when head > max do
    #     get(tail, count + 1, total + head, min, head)
    # end
    # defp get([head | tail], count, total, min, max) do
    #     get(tail, count + 1, total + head, min, max)
    # end

    defp get_std(list, mean, counter \\ 0, acc \\ 0)
    defp get_std([:missing | tail], mean, counter, acc) do
        get_std(tail, mean, counter, acc)
    end
    defp get_std([head | tail], mean, counter, acc) do
        get_std(tail, mean, counter + 1, acc + :math.pow(head - mean, 2))
    end
    defp get_std([], _mean, counter, acc) do
        :math.sqrt(acc / counter)
    end

    defp get_quartile(list, count, percent) do
      Enum.at list, round(Float.floor count * percent / 100)
    end

end

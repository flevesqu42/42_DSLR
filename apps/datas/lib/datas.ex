defmodule Datas do

    def classes do
    [
        "Arithmancy",
        "Astronomy",
        "Herbology",
        "Defense Against the Dark Arts",
        "Divination",
        "Muggle Studies",
        "Ancient Runes",
        "History of Magic",
        "Transfiguration",
        "Potions",
        "Care of Magical Creatures",
        "Charms",
        "Flying"
    ]
    end

    def houses do
    [
        "Ravenclaw",
        "Hufflepuff",
        "Slytherin",
        "Gryffindor"
    ]
    end

    def guessed_feature do
      "Hogwarts House"
    end

    def index do
      "Index"
    end

    def features do
        Datas.classes |> Enum.map(fn e -> {e, 0} end) |> Map.new
    end

    def standardise(dataset, describe, acc \\ [])
    def standardise([], _describe, acc), do: acc
    def standardise([head | tail], describe, acc) do
        standardise(tail, describe, [standardise_data(head, describe) | acc])
    end

    defp standardise_data(data, describe, features \\ classes())
    defp standardise_data(data, _describe, []), do: data
    defp standardise_data(data, describe, [feature | tail]) do
        case data[feature] do
            ""  -> standardise_data(data, describe, tail)
            num -> standardise_data(%{data | feature => (num - describe[feature].mean) / describe[feature].range * 2.0}, describe, tail)
        end
    end

    def all_thetas do
      Datas.houses |> Map.new(fn x -> {x, nil} end)
    end

    def houses_by_classes(default_value \\ []) do
      classes() |> Enum.map(fn e -> {e, Map.new(Enum.map(houses(), fn house -> {house, default_value} end))} end) |> Map.new
    end

    def split_map_by_classes(dataset, opt \\ :all, houses_by_classes \\ houses_by_classes())
    def split_map_by_classes([], _opt, houses_by_classes), do: houses_by_classes
    def split_map_by_classes([user | tail], opt, houses_by_classes) do
      split_map_by_classes tail, opt, parse_classes_for_user(user, opt, classes(), houses_by_classes)
    end

    defp parse_classes_for_user(user, opt, classes, acc)
    defp parse_classes_for_user(_user, _opt, [], acc), do: acc
    defp parse_classes_for_user(user, opt, [class_head | classes_tail], acc) do
        case {opt == :all or (opt == :only_float and is_float(user[class_head])), user[guessed_feature()]} do
            {_, nil}        -> ErrorHandler.puts :bad_csv_format, :critical
            {true, class}   -> parse_classes_for_user(user, opt, classes_tail, %{acc | class_head => %{acc[class_head] | class => [user[class_head] | acc[class_head][class]]}})
            {false, _class} -> parse_classes_for_user(user, opt, classes_tail, acc)
        end
    end
end

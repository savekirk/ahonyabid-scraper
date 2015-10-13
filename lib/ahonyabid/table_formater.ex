defmodule AhonyaBid.TableFormater do
  import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]


  def print_table_columns(rows, headers) do
    data_by_columns = split_into_columns(rows, headers)
    column_widths   = widths_of(data_by_columns)
    format          = format_for(column_widths)

    add_column_sep   headers, format
    IO.puts          separator(column_widths)
    create_columns   data_by_columns, format
  end


  def split_into_columns(rows, headers) do
    for header <- headers do
      for row <- rows, do: printable(Map.get(row, String.to_atom(header)))
    end
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def widths_of(columns) do
    for column <- columns, do: column |> map(&String.length/1) |> max
  end

  def format_for(column_widths) do
    map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(column_widths) do
    map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def create_columns(data_by_columns, format) do
    data_by_columns
    |> List.zip
    |> map(&Tuple.to_list/1)
    |> each(&add_column_sep(&1, format))
  end

  def add_column_sep(fields, format) do
    :io.format(format, fields)
  end
end

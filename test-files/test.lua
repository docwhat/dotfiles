-- shellsort.lua
-- Written by Rici Lake. The author disclaims all copyright and offers no warranty.
--
-- This module returns a single function (not a table) whose interface is upwards-
-- compatible with the interface to table.sort:
--
-- array = shellsort(array, before, n)
-- array is an array of comparable elements to be sorted in place
-- before is a function of two arguments which returns true if its first argument
--    should be before the second argument in the second result. It must define
--    a total order on the elements of array.
--      Alternatively, before can be one of the strings "<" or ">", in which case
--    the comparison will be done with the indicated operator.
--    If before is omitted, the default value is "<"
-- n is the number of elements in the array. If it is omitted, #array will be used.
-- For convenience, shellsort returns its first argument.

do
  local incs = { 1391376,
                 463792, 198768, 86961, 33936,
                 13776, 4592, 1968, 861, 336,
                 112, 48, 21, 7, 3, 1 }

  local function ssup(t, n)
    for _, h in ipairs(incs) do
      for i = h + 1, n do
        local v = t[i]
        for j = i - h, 1, -h do
          local testval = t[j]
          if not (v < testval) then break end
          t[i] = testval; i = j
        end
        t[i] = v
      end
    end
    return t
  end

  local function ssdown(t, n)
    for _, h in ipairs(incs) do
      for i = h + 1, n do
        local v = t[i]
        for j = i - h, 1, -h do
          local testval = t[j]
          if not (v > testval) then break end
          t[i] = testval; i = j
        end
        t[i] = v
      end
    end
    return t
  end

  local function ssgeneral(t, n, before)
    for _, h in ipairs(incs) do
      for i = h + 1, n do
        local v = t[i]
        for j = i - h, 1, -h do
          local testval = t[j]
          if not before(v, testval) then break end
          t[i] = testval; i = j
        end
        t[i] = v
      end
    end
    return t
  end

  function shellsort(t, before, n)
    n = n or #t
    if not before or before == "<" then return ssup(t, n)
    elseif before == ">" then return ssdown(t, n)
    else return ssgeneral(t, n, before)
    end
  end
  return shellsort
end

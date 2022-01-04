--- shift register and scale builder from cv

r = {0,0,0,0}
s = {}

function round(x)
  return x % 1 >= 0.5 and math.ceil(x) or math.floor(x)
end

function new_cv()
  -- random pitch cv generator with instability, for testing purposes
  local random_note = math.random(-23,23)
  local error_margin = math.random() * math.random(-1,1) / 10
  return (random_note + error_margin) / 12
end

function do_shift(shift_register, val)
  val = round(val * 12)
  table.insert(shift_register, 1, val)
  table.remove(shift_register, #shift_register)
end

function do_scale(scale, val)
  val = round(val * 12) % 12

  local val_is_duplicate
  for k, v in ipairs(scale) do
    if val == v then val_is_duplicate = true end
  end
  
  if not val_is_duplicate then
    table.insert(scale, val)
  end

  table.sort(scale)
end


function run(shift_register, scale)
  local v = new_cv()
  do_shift(shift_register, v)
  do_scale(scale, v)

  -- print shift_register
  for i = 1, #shift_register do
    print(shift_register[i])
  end

  print()

  -- print scale
  for i = 1, #scale do
    print(scale[i])
  end

end



-- create a function that adds generated note to a table -done
-- remove duplicates -done
-- sort in order -done
-- multiply cv value x 12 -done
-- round to cv value integer -done
-- remove transposed octaves - use % -done
-- 
-- create a pentatonic scale from the notes

-- other ideas which you may or may not wish to add:
-- play a third up from current note, etc
-- can use Vox
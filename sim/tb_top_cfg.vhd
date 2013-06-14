
library work;

configuration prelayout of tb_top is
  for sim
    for i_top : top
      use entity work.top(struc);
    end for;
  end for;
end configuration prelayout; 

library work;

configuration postlayout of tb_top is
  for sim
    for i_top : top
      use entity work.top(structure);
    end for;
  end for;
end configuration postlayout;

%% Copyright (C) 2015-2017 Colin B. Macdonald
%% Copyright (C) 2016 Lagu
%%
%% This file is part of OctSymPy.
%%
%% OctSymPy is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published
%% by the Free Software Foundation; either version 3 of the License,
%% or (at your option) any later version.
%%
%% This software is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty
%% of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
%% the GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public
%% License along with this software; see the file COPYING.
%% If not, see <http://www.gnu.org/licenses/>.

%% -*- texinfo -*-
%% @deftypefun {[@var{s}, @var{flag}] =} const_to_python_str (@var{x})
%% Recognize constant and return their python string equivalent.
%%
%% Private helper function.
%%
%% @seealso{sym, vpa}
%% @end deftypefun

function [s, flag] = const_to_python_str (x)

  % Table of special strings.  Format for each row is:
  %    <unused> {list of strings to recognize}, resulting python expr
  % Note: case sensitive
  % Note: python expr should be in list for identity "sym(sympy(x)) == x"
  list = {pi {'pi'} 'S.Pi'; ...
          inf {'inf' 'Inf' 'oo'} 'S.Infinity'; ...
          nan {'NaN' 'nan'} 'S.NaN'; ...
          [] {'zoo'} 'S.ComplexInfinity'};

  flag = 1;

  assert (ischar (x))

    for j = 1:length (list)
      for n = 1:length (list{j, 2})
        if (strcmp (x, list{j, 2}{n}) || strcmp (x, ['+' list{j, 2}{n}]))
          s = list{j, 3};
          return
        elseif (strcmp (x, ['-' list{j, 2}{n}]))
          s = ['-' list{j, 3}];
          return
        end
      end
    end

    flag = 0;
    s = x;

end

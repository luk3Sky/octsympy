%% Copyright (C) 2016 Colin B. Macdonald and Lagu
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
%% @deftypefn {Function File}  {@var{r} =} union (@var{A}, @var{B})
%% @deftypefnx {Function File}  {@var{r} =} union (@var{A}, @var{B}, @dots{}, 'intervals')
%% Return the union of elements of two sets.
%%
%% @seealso{intersect, setdiff, setxor,function r = intersect(varargin)

function r = union(varargin)

  varargin = sym(varargin);

  cmd = {
         'def to_inter(a):'
         '    if isinstance(a, sp.Set):'
         '        return a'
         '    elif not isinstance(a, sp.MatrixBase):'
         '        return Interval(a, a)'
         '    elif len(a) == 1:'
         '        return Interval(a, a)'
         '    else:'
         '        return Interval(*a)'
         ''
         'def inter(x):'
         '    t = to_inter(x[0])'
         '    for i in range(1, len(x)):'
         '        t = Union(t, to_inter(x[i]))'
         '    return t,'
         '#'
         'x = _ins'
         'if str(x[-1]) == "intervals":'
         '    del x[-1]'
         '    return inter(x),'
         ''
         'for i in _ins:'
         '    if isinstance(i, sp.Set):'
         '        return inter(x),'
         ''
         'A = sp.FiniteSet(*(list(x[0]) if isinstance(x[0], sp.MatrixBase) else [x[0]]))'
         'B = sp.FiniteSet(*(list(x[1]) if isinstance(x[1], sp.MatrixBase) else [x[1]]))'
         'C = Union(A, B)'
         'return sp.Matrix([[list(C)]]),'
        };

    r = python_cmd (cmd, varargin{:});
    r = horzcat(r{:});

end


%!test
%! A = sym([1 2 3]);
%! B = sym([1 2 4]);
%! C = union(A, B);
%! D = sym([1 2 3 4]);
%! assert (isequal (C, D))

%!test
%! % one nonsym
%! A = sym([1 2 3]);
%! B = [1 2 4];
%! C = union(A, B);
%! D = sym([1 2 3 4]);
%! assert (isequal (C, D))

%!test
%! % empty
%! A = sym([1 2 3]);
%! C = union(A, A);
%! assert (isequal(C, A))

%!test
%! % empty input
%! A = sym([1 2]);
%! C = union(A, []);
%! assert (isequal (C, sym([1 2])))


%!test
%! % scalar
%! syms x
%! assert (isequal (union([x 1], x), [1 x]))
%! assert (isequal (union(x, x), x))

%!test
%! A = interval(sym(1), 3);
%! B = interval(sym(2), 5);
%! C = union(A, B);
%! assert( isequal( C, interval(sym(1), 5)))
%! assert( isequal( C, union (A, B, "intervals")))

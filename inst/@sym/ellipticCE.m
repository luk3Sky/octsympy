%% Copyright (C) 2016-2017 Lagu
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
%% @documentencoding UTF-8
%% @defmethod @@sym ellipticCE (@var{m})
%% Complementary complete elliptic integral of the second kind.
%%
%% This is the complete elliptic integral (of the second kind) with the
%% complementary parameter @code{1 - @var{m}}:
%% @example
%% @group
%% syms m
%% ellipticCE (m)
%%   @result{} ans = (sym) E(-m + 1)
%% @end group
%% @end example
%%
%% Example:
%% @example
%% @group
%% ellipticCE (sym(1)/3)
%%   @result{} ans = (sym) E(2/3)
%% double (ans)
%%   @result{} ans = 1.2612
%% @end group
%% @end example
%%
%% There are other conventions for the inputs of elliptic integrals,
%% @pxref{@@sym/ellipticF}.
%%
%% @seealso{@@sym/ellipticE}
%% @end defmethod


function y = ellipticCE(m)
  if (nargin > 1)
    print_usage ();
  end

  y = ellipticE (sym (pi)/2, 1 - m);

end


%!error <Invalid> ellipticCE (sym (1), 2)

%!assert (isequal (ellipticCE (sym (0)), sym (1)))
%!assert (isequal (ellipticCE (sym (1)), sym (pi)/2))
%!assert (double (ellipticCE (sym (pi)/4)), 1.482786927, 10e-10)
%!assert (double (ellipticCE (sym (pi)/2)), 1.775344699, 10e-10)

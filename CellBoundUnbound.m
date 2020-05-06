function unbound_element = CellBoundUnbound(chanceToBind, chanceToUnbind, ...
    unbound, t, k)
% Compute whether the cell responds to bound or unbound chemokine.

randomNum = unifrnd(0,1);

% If the cell is currently bound and the unbound condition is met, mark
% the cell as unbound.
if (~unbound(k,t)) && (randomNum <= chanceToUnbind)
    unbound_element = 1;
% If cell is currently unbound and the binding condition is met, mark
% the cell as bound.
elseif (unbound(k,t)) && (randomNum <= chanceToBind)
    unbound_element = 0;
else
    % Stay in the same state by default
    unbound_element = unbound(k,t);    
end
end


function data = fixpos(data, recurse)

% helper function to replace pnt by pos

if nargin==1
  recurse = 1;
end

if numel(data)>1
  % loop over all individual elements
  for i=1:numel(data)
    data(i) = fixpos(data(i));
  end
  return
end

% replace pnt by pos
if isfield(data, 'pnt') && ~isfield(data, 'label')
  data.pos = data.pnt;
  data = rmfield(data, 'pnt');
end

if recurse<3
  % recurse into substructures, not too deep
  fn = fieldnames(data);
  fn = setdiff(fn, {'cfg'}); % don't recurse into the cfg structure
  for i=1:length(fn)
    if isstruct(data.(fn{i}))
      data.(fn{i}) = fixpos(data.(fn{i}), recurse+1);
    end
  end
end

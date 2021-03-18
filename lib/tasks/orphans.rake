desc "Find and delete recipes with no alcoholic ingredients and updated more than 15 minutes ago."
task({ :delete_orphans => :environment }) do

  orphans = Array.new
  
  Recipe.all.each do |a_recipe|
    ing_count = a_recipe.ingredients.count
    if ing_count == 0
      orphans.push(a_recipe.id)
    end
  end

  p "#{orphans.count} orphaned recipes found."
  p "#{orphans}"

  if orphans != 0
  
    orphans_to_delete = Recipe.where({ :id => orphans }).where("updated_at < ?", 15.minutes.ago)

    p "#{orphans_to_delete.count} of #{orphans.count} updated more than 15 minutes ago."
    p "#{orphans_to_delete}"

    if orphans_to_delete != 0

      p "Destroying orphaned recipes."

      orphans_to_delete.each do |orphan|
        orphan.destroy
      end

    end

    new_orphans = Array.new
  
    Recipe.all.each do |a_recipe|
      ing_count = a_recipe.ingredients.count
      if ing_count == 0
        new_orphans.push(a_recipe.id)
      end
    end

    p "#{new_orphans.count} orphaned recipes remain."
    p "#{new_orphans}"

  end

end
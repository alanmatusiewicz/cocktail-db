desc "Find and delete recipes with no alcoholic ingredients and created more than 15 minutes ago."
task({ :delete_orphans => :environment }) do

  orphans = Array new
  
  Recipe.all.each do |a_recipe|
    ing_count = recipe.ingredients.count
    if ing_count == 0
      orphans.push(recipe.id)
    end
  end

  p "#{orphans} orphan recipes found."

  if orphans != 0
  
    clean_orphans = Recipe.where({ :id => orphans }).where("created_at > ?", 15.minutes.ago)

    p "#{clean_orphans} of #{orphans} created more than 15 minutes ago."

    if clean_orphans != 0

      p "Destroying orphaned recipes."

      clean_orphans.each. do |orphan|
        orphan.destroy
      end

    end

    new_orphans = Array new
  
    Recipe.all.each do |a_recipe|
      ing_count = recipe.ingredients.count
      if ing_count == 0
        new_orphans.push(recipe.id)
      end
    end

    p "#{new_orphans} orphan recipes remain."

  end

end
module NavigationHelpers
  module Refinery
    module Tutorials
      def path_to(page_name)
        case page_name
        when /the list of tutorials/
          admin_tutorials_path

         when /the new tutorial form/
          new_admin_tutorial_path
        else
          nil
        end
      end
    end
  end
end

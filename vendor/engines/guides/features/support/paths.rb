module NavigationHelpers
  module Refinery
    module Guides
      def path_to(page_name)
        case page_name
        when /the list of guides/
          admin_guides_path

         when /the new guide form/
          new_admin_guide_path
        else
          nil
        end
      end
    end
  end
end

module API
    module V3
      module Kittens
        class KittensAPI < ::API::OpenProjectAPI
          resources :kittens do
            get do
              # the distinct(false) is added in order to allow ORDER BY LOWER(name)
              # which would otherwise be invalid in postgresql
              # SELECT DISTINCT, ORDER BY expressions must appear in select list
              ::API::V3::Utilities::ParamsToQuery.collection_response(Kitten.visible(current_user).distinct(false),
                                                                      current_user,
                                                                      params)
            end
  
            route_param :id do
              before do
                @kitten = Kitten.find(params[:id])
  
                authorized_for_kitten?(@kitten)
              end
  
              helpers do
                def authorized_for_kitten?(kitten)
                  projects = kitten.projects
  
                  permissions = %i(view_work_packages manage_kittens)
  
                  authorize_any(permissions, projects: projects, user: current_user)
                end
              end
  
              get do
                KittenRepresenter.new(@kitten, current_user: current_user)
              end
  
              mount ::API::V3::Kittens::ProjectsByKittenAPI
            end
          end
        end
      end
    end
  end
  
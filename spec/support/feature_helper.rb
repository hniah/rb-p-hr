module FeatureHelper
  def get_element(element)
    find("[data-test='#{element}']")
  end

  def feature_login(user)
    login_as user
  end
end

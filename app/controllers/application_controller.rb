class ApplicationController < ActionController::Base
    # ログインしてないとき、ログイン画面へリダイレクト
    before_action :authenticate_user!, except: [:top, :about]  
    # devise利用の機能が使われる前に、configure_permitted_parametersメソッドが実行
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_in_path_for(resource)
      user_path(resource)
    end
    
    def after_sign_out_path_for(resource)
        root_path
    end
        
    protected
    
    def configure_permitted_parameters
        # sign_upでどの要素を許可するか
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end
    
end

class ApplicationPolicy
  class << self
    def policies
      @policies ||= Dir[Rails.root.join("app/policies/*_policy.rb")].map do |file|
        File.basename(file).chomp('.rb').camelize.constantize unless file == File.basename(__FILE__)
      end.compact
    end

    def policy(&block)
      instance_eval(&block)
    end

    def actions
      @actions ||= {}
    end

    def resource(name)
      self.resource_name = name
    end

    attr_accessor :comment
    def desc(comment)
      @comment = comment
    end

    def resource_name
      @resource_name ||= name.chomp("Policy")
    end

    def resource_name=(name)
      @resource_name = name
    end

    def permit(action, comment)
      define_method("#{action}?") do
        can? action
      end
      actions[action] = comment
    end
  end

  def can? action
    permision = { action: action, resource: self.class.resource_name }
    user.permissions.exists? permision
  end


  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

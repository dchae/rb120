module ParentMixin
  # CONS = "PARENT MIXIN"
end
module ChildMixin
  # CONS = "CHILD MIXIN"
end

CONS = "MAIN"
module Outer
  CONS = "OUTER MODULE"

  module Inner
    # CONS = "INNER MODULE"

    class Parent
      include ParentMixin
      # CONS = "PARENT CLASS"
    end

    class Child < Parent
      include ChildMixin
      # CONS = "CHILD CLASS"
    
      def lexical_scope
        CONS
      end
    end
  end
end


class Outer::Inner::Child
  def lexical_scope2
    CONS
  end
end

test_class = Outer::Inner::Child.new

p test_class.lexical_scope2
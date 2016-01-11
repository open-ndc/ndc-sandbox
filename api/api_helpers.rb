module API

  module APIHelpers

    def cos_to_marketing_name(cos)
      case cos
      when 'Y'
        "World Traveller"
      else
        "Wadus Class"
      end
    end

  end

end

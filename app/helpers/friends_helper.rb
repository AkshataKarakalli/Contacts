module FriendsHelper
    def first_name(friend)
        if @friend.gender == "M"
          "Mr. #{@friend.first_name}"
        else
            "Ms. #{@friend.first_name}"
        end
    end
end

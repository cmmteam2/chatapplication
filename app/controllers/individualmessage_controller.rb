class IndividualmessageController < ApplicationController
    def index
        @individualmessages = Individualmessage.all
    end
end

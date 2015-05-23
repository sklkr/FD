class FpConditioner
	def initialize(fpclass, passport)
	 @fpclass = fpclass
	 @passport = passport
	 @clasbkings = @passport.clasbkings
    end

    # day done is method used to check that current customer active classes should not be greater than 8
	def day_done
	 @clasbkings.count < 8
	end

	def is_this_class_full
	 @clasbkings.where('fpclass_id=?', @fpclass.id).count < 3
	end

	def is_he_eligible
		!is_classes_full || !is_this_class_full
	end
end


=begin
	if !(passport.clasbkings.where('fpclass_id=?', @fpclass.id).count < 3 ) || !(passport.clasbkings.count < 7)
		
		if @booking.save
			respond_to do |format|
				format.js
			end
		else
			render :json => "something went wrong"
		end
	else
		render js: "alert('one can book 7 active passes with only 3 repetive classes');"
	end
=end

require 'mongo'

class Connection_to_Mongo
	
		# -------------------- Code for getting connect to the Mongodb ----------------------
	def getConnection
		print "Do you want to create new Database and Collection or Continue with default One for Yes Y for No N\n"
		dbop = gets.chomp
			case dbop
				when "Y","y"
					print "Enter Database name and Collection Name \n"	
					@dbname = gets.chomp;
					@colname = gets.chomp;
				when "N" , "n"
					@dbname = "rubydb"
					@colname = "products"
					puts "Ok we will continue with default Database and collection"
				else
					@dbname = "rubydb"
					@colname = "products"
					puts "Wrong Option"
			end					
			
		begin
			@dbcon = Mongo::Connection.new.db(@dbname)
			@dbcol = @dbcon[@colname]
			select_Operation
		rescue
			puts "Problem occur while getting connection with MongoDB"
		end
		
	end


		# --------------------- Selecting CRUD Operations -------------------------------
	def select_Operation
		print "1. Inserting Document \n"
		print "2. Selecting Document \n"
		print "3. Updating Document \n"
		print "4. Removing Document \n"
		op = gets.chomp.to_i;
			case op
				when 1
					inserting_Document
				when 2
					selecting_Document
				when 3
					updating_Document
				when 4
					removing_Document
				else
					puts "Sorry Invalid Option"
			end
	end

		#-------- Code for Inserting Records / Documents into the student colleciton of Mongodb --------
	def inserting_Document
		begin
			print "Enter Product Id: \n"
			pno = gets.chomp.to_i;
			print "Enter Product Name: \n"
			pname = gets.chomp;
			print "Enter Product Cost: \n"
			pcost = gets.chomp.to_i;
			print "Enter Product Quantity: \n"
			pqty = gets.chomp.to_i;
			@dbcol.insert({_id:pno,pro_name:"#{pname}",pro_cost:pcost,pro_qty:pqty})
			puts "Record Inserted Successfully............"
		rescue
			puts "Problem Occure at Record Insertion ............"
		end
	end


		# -------------- Retrieving the Documents from the student collection ---------------
	def selecting_Document
				#------------ Prompting the user for displaying records of all or particular ------------
		print "Select all Documents or Particular Documents \n"
		print "1. All Documents / Records \n"
		print "2. Particular Documents / Record \n"
		sop = gets.chomp.to_i
			case sop
					#------------------- For all records the below code goes ---------------------
				when 1
					begin
						rec = @dbcol.find.to_a
	
						printf "\n"
						fields = rec[0].keys
						print "\t"
						print "+==================================================================+ \n"
						print "\t|"
						print "\t"
						for i in 0...fields.size do
							print "#{rec[0].keys[i]}\t   |   "
						end
						print "\n"
						print "\t"
						print "+==================================================================+ \n"
			
						for k in 0...rec.size do
							print "\t|"
							print "\t"
							for j in 0...rec[k].values.size do
								print "#{rec[k].values[j]} \t   | "
							end
							print "\n"
						end
						print "\t"
						print "+==================================================================+ \n"
						printf "\n"
					rescue
						puts "Sorry No data Found ............"
					end

					#---------------------- for particular record ----------------------------
				when 2
						
					begin
						print "Enter which record you want:\n"
						num = gets.chomp.to_i
						rec1 = @dbcol.find_one({_id:num})
						print "\t"							
						print "+===================================================================+ \n"
						print "\t|"
						print "\t"
						for i in 0...rec1.keys.size do
							print "#{rec1.keys[i]} \t  |    "
						end
						print "\n"
						print "\t"	
						print "+===================================================================+ \n"
						print "\t|"
						print "\t"
						for j in 0...rec1.values.size do
							print "#{rec1.values[j]} \t    |    "
						end
						print "\n"
						print "\t"
						print "+===================================================================+ \n"
						print "\n"	
					rescue
						puts "No record found with that value"
					end
				else
					puts "Sorry Invalid Option try again ....."
			end
	end
		

		# ------------------- Updating Documents of a student collection ----------------------
	def updating_Document
			begin
						#----- Selecting Field to change their value -------
				recs = @dbcol.find.to_a
				fields = recs[0].keys
				print "In the following fields which field do you want to modify \n"
						#-------- Gathering all the fields in student collection ----------
				for i in 0...fields.size do
					puts "#{i+1}. #{recs[0].keys[i]}"
				end
				field_op = gets.chomp.to_i
					case field_op
						when 1
							print "Enter id of record which you want to update / Modify \n"
							update_no = gets.chomp.to_i;
							print "Enter value to change \n"
							update_no2 = gets.chomp.to_i;
							begin
								@dbcol.update({recs[0].keys[0] => update_no}, {"$set" => {recs[0].keys[0] => update_no2}});
								puts "Record updated successfully.............."
							rescue
								puts "Sorry for inconvenience we cant change the value of an id"
							end
						when 2
							print "Enter id of record which you want to update / Modify \n"
							update_no = gets.chomp.to_i;
							print "Enter name to change \n"
							update_name = gets.chomp
							begin
								@dbcol.update({recs[0].keys[0] => update_no}, {"$set" => {recs[0].keys[1] => update_name}});
								puts "Record updated successfully.............."
							rescue
								puts "Problem occure while updating the record"
							end
						when 3
							print "Enter id of record which you want to update / Modify \n"
							update_no = gets.chomp.to_i;
							print "Enter Cost to change \n"
							update_cost = gets.chomp
							begin
								@dbcol.update({recs[0].keys[0] => update_no}, {"$set" => {recs[0].keys[2] => update_cost}});
								puts "Record updated successfully.............."
							rescue
								puts "Problem occure while updating the record"
							end
						when 4
							print "Enter id of record which you want to update / Modify \n"
							update_no = gets.chomp.to_i;
							print "Enter Quantity to change \n"
							update_qty = gets.chomp
							begin
								@dbcol.update({recs[0].keys[0] => update_no}, {"$set" => {recs[0].keys[3] => update_city}});
								puts "Record updated successfully.............."
							rescue
								puts "Problem occure while updating the record"
							end
						else
							puts "Sorry Invalid option try again later"
					end
			rescue
				puts "Problem occure"
			end
	end

		# ------------------- Removing Documents from a student collection -----------------------
	def removing_Document
		begin
			print "Do you want all records to delete or Particular Records \n"
			print "1. All Records \n"
			print "2. Particular Records \n"
			remove_op = gets.chomp.to_i;
				case remove_op
					when 1
						begin
							@dbcol.remove()
							puts "Records Deleted Successfully"
						rescue	
							puts "Problem"
						end
						
					when 2
						begin
							print "Enter id to remove the record \n"
							rid = gets.chomp.to_i
							@dbcol.remove({"_id"=>rid})
							puts "Records Deleted Successfully"
						rescue	
							puts "Problem"
						end
					else
						puts "Invalid Option"
				end
		rescue
			puts "Problem Occure while deleting the record"
		end
	end

end

cc = Connection_to_Mongo.new
cc.getConnection



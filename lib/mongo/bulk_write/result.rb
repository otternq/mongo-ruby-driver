# Copyright (C) 2015 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Mongo
  module BulkWrite

    # Wraps a series of bulk write operations in a result object.
    #
    # @since 2.0.6
    class Result

      # Returns the number of documents deleted.
      #
      # @example Get the number of deleted documents.
      #   result.deleted_count
      #
      # @return [ Integer ] The number deleted.
      #
      # @since 2.1.0
      def deleted_count
        @results[BulkWritable::REMOVED_COUNT]
      end

      # Create the new result object from the results document.
      #
      # @example Create the new result.
      #   Result.new({ 'n_inserted' => 10 })
      #
      # @param [ BSON::Document, Hash ] results The results document.
      #
      # @since 2.1.0
      def initialize(results)
        @results = results
      end

      # Returns the number of documents inserted.
      #
      # @example Get the number of inserted documents.
      #   result.inserted_count
      #
      # @return [ Integer ] The number inserted.
      #
      # @since 2.1.0
      def inserted_count
        @results[BulkWritable::INSERTED_COUNT]
      end

      # Get the inserted document ids, if the operation has inserts.
      #
      # @example Get the inserted ids.
      #   result.inserted_ids
      #
      # @return [ Array<BSON::ObjectId> ] The inserted ids.
      #
      # @since 2.1.0
      def inserted_ids
        @results[BulkWritable::INSERTED_IDS]
      end

      # Returns the number of documents matched.
      #
      # @example Get the number of matched documents.
      #   result.matched_count
      #
      # @return [ Integer ] The number matched.
      #
      # @since 2.1.0
      def matched_count
        @results[BulkWritable::MATCHED_COUNT]
      end

      # Returns the number of documents modified.
      #
      # @example Get the number of modified documents.
      #   result.modified_count
      #
      # @return [ Integer ] The number modified.
      #
      # @since 2.1.0
      def modified_count
        @results[BulkWritable::MODIFIED_COUNT]
      end

      # Returns the number of documents upserted.
      #
      # @example Get the number of upserted documents.
      #   result.upserted_count
      #
      # @return [ Integer ] The number upserted.
      #
      # @since 2.1.0
      def upserted_count
        @results[BulkWritable::UPSERTED_COUNT]
      end

      # Get the upserted document ids, if the operation has inserts.
      #
      # @example Get the upserted ids.
      #   result.upserted_ids
      #
      # @return [ Array<BSON::ObjectId> ] The upserted ids.
      #
      # @since 2.1.0
      def upserted_ids
        @results[BulkWritable::UPSERTED_IDS]
      end

      # Validates the bulk write result.
      #
      # @example Validate the result.
      #   result.validate!
      #
      # @raise [ Error::BulkWriteError ] If the result contains errors.
      #
      # @return [ Result ] The result.
      #
      # @since 2.1.0
      def validate!
        if @results[Error::WRITE_ERRORS] || @results[Error::WRITE_CONCERN_ERRORS]
          raise Error::BulkWriteError.new(@results)
        else
          self
        end
      end
    end
  end
end
